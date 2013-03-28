From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] Updated PowerTOP AHCI ALPM accounting for Device Sleep.
Date: Thu, 28 Mar 2013 12:21:17 +0000
Message-ID: <1364473277.14860.33.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha1"; protocol="application/x-pkcs7-signature";
	boundary="=-0WhkqUfuROxe/G5PS+I1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:46319
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754918Ab3C1MVX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Mar 2013 08:21:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: powertop@ml01.01.org, arjan@linux.intel.com, "Accardi, Kristen C" <kristen.c.accardi@intel.com>


--=-0WhkqUfuROxe/G5PS+I1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch applies to v3.7 onwards (including 3.9-rc4), and adds devslp
support to the AHCI state accounting. It's based on the patch at
https://raw.github.com/fenrus75/powertop/master/patches/linux-3.3.0-ahci-al=
pm-accounting.patch

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: libata: Add ALPM power state accounting to the AHCI driver

PowerTOP wants to be able to show the user how effective the ALPM link
power management is for the user. ALPM is worth around 0.5W on a quiet
link; PowerTOP wants to be able to find cases where the "quiet link" isn't
actually quiet.

This patch adds state accounting functionality to the AHCI driver for
PowerTOP to use.
The parts of the patch are
1) the sysfs logic of exposing the stats for each state in sysfs
2) the basic accounting logic that gets update on link change interrupts
   (or when the user accesses the info from sysfs)
3) a "accounting enable" flag; in order to get the accounting to work,
   the driver needs to get phyrdy interrupts on link status changes.
   Normally and currently this is disabled by the driver when ALPM is
   on (to reduce overhead); when PowerTOP is running this will need
   to be on to get usable statistics... hence the sysfs tunable.

The PowerTOP output currently looks like this:

Recent SATA AHCI link activity statistics
Active	Partial	Slumber	Device name
  0.5%	 99.5%	  0.0%	host0

(work to resolve "host0" to a more human readable name is in progress)

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
[root@dyn-252 host1]# grep ^ ahci_alpm_*
ahci_alpm_accounting:1
ahci_alpm_active:1334912
ahci_alpm_devslp:251547
ahci_alpm_partial:0
ahci_alpm_slumber:1020283


diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 9be4712..3a7584c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -285,6 +285,14 @@ struct ahci_em_priv {
 	unsigned long led_state;
 };
=20
+enum ahci_port_states {
+	AHCI_PORT_NOLINK =3D 0,
+	AHCI_PORT_ACTIVE =3D 1,
+	AHCI_PORT_PARTIAL =3D 2,
+	AHCI_PORT_SLUMBER =3D 3,
+	AHCI_PORT_DEVSLP =3D 4
+};
+
 struct ahci_port_priv {
 	struct ata_link		*active_link;
 	struct ahci_cmd_hdr	*cmd_slot;
@@ -303,6 +311,15 @@ struct ahci_port_priv {
 	int			fbs_last_dev;	/* save FBS.DEV of last FIS */
 	/* enclosure management info per PM slot */
 	struct ahci_em_priv	em_priv[EM_MAX_SLOTS];
+
+	/* ALPM accounting state and stats */
+	unsigned int 		accounting_active:1;
+	u64			active_jiffies;
+	u64			partial_jiffies;
+	u64			slumber_jiffies;
+	u64			devslp_jiffies;
+	int			previous_state;
+	int			previous_jiffies;
 };
=20
 struct ahci_host_priv {
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 6cd7805..96a1ff7 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -100,6 +100,19 @@ static ssize_t ahci_activity_store(struct ata_device *=
dev,
 				   enum sw_activity val);
 static void ahci_init_sw_activity(struct ata_link *link);
=20
+static ssize_t ahci_alpm_show_active(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_alpm_show_slumber(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_alpm_show_devslp(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_alpm_show_partial(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_alpm_show_accounting(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_alpm_set_accounting(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count);
 static ssize_t ahci_show_host_caps(struct device *dev,
 				   struct device_attribute *attr, char *buf);
 static ssize_t ahci_show_host_cap2(struct device *dev,
@@ -120,6 +133,13 @@ static DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_=
host_caps, NULL);
 static DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
 static DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NUL=
L);
 static DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
+static DEVICE_ATTR(ahci_alpm_active, S_IRUGO, ahci_alpm_show_active, NULL)=
;
+static DEVICE_ATTR(ahci_alpm_partial, S_IRUGO, ahci_alpm_show_partial, NUL=
L);
+static DEVICE_ATTR(ahci_alpm_slumber, S_IRUGO, ahci_alpm_show_slumber, NUL=
L);
+static DEVICE_ATTR(ahci_alpm_devslp, S_IRUGO, ahci_alpm_show_devslp, NULL)=
;
+static DEVICE_ATTR(ahci_alpm_accounting, S_IRUGO | S_IWUSR,
+		ahci_alpm_show_accounting, ahci_alpm_set_accounting);
+
 static DEVICE_ATTR(em_buffer, S_IWUSR | S_IRUGO,
 		   ahci_read_em_buffer, ahci_store_em_buffer);
 static DEVICE_ATTR(em_message_supported, S_IRUGO, ahci_show_em_supported, =
NULL);
@@ -132,6 +152,11 @@ struct device_attribute *ahci_shost_attrs[] =3D {
 	&dev_attr_ahci_host_cap2,
 	&dev_attr_ahci_host_version,
 	&dev_attr_ahci_port_cmd,
+	&dev_attr_ahci_alpm_active,
+	&dev_attr_ahci_alpm_partial,
+	&dev_attr_ahci_alpm_slumber,
+	&dev_attr_ahci_alpm_devslp,
+	&dev_attr_ahci_alpm_accounting,
 	&dev_attr_em_buffer,
 	&dev_attr_em_message_supported,
 	NULL
@@ -224,6 +249,182 @@ static void ahci_enable_ahci(void __iomem *mmio)
 	WARN_ON(1);
 }
=20
+static int get_current_alpm_state(struct ata_port *ap)
+{
+	u32 status =3D 0;
+
+	ahci_scr_read(&ap->link, SCR_STATUS, &status);
+
+	/* link status is in bits 11-8 */
+	status =3D status >> 8;
+	status =3D status & 0xf;
+
+	if (status =3D=3D 8)
+		return AHCI_PORT_DEVSLP;
+	if (status =3D=3D 6)
+		return AHCI_PORT_SLUMBER;
+	if (status =3D=3D 2)
+		return AHCI_PORT_PARTIAL;
+	if (status =3D=3D 1)
+		return AHCI_PORT_ACTIVE;
+	return AHCI_PORT_NOLINK;
+}
+
+static void account_alpm_stats(struct ata_port *ap)
+{
+	struct ahci_port_priv *pp;
+
+	int new_state;
+	u64 new_jiffies, jiffies_delta;
+
+	if (ap =3D=3D NULL)
+		return;
+	pp =3D ap->private_data;
+
+	if (!pp) return;
+
+	new_state =3D get_current_alpm_state(ap);
+	new_jiffies =3D jiffies;
+
+	jiffies_delta =3D new_jiffies - pp->previous_jiffies;
+
+	switch (pp->previous_state) {
+	case AHCI_PORT_NOLINK:
+		pp->active_jiffies =3D 0;
+		pp->partial_jiffies =3D 0;
+		pp->slumber_jiffies =3D 0;
+		break;
+	case AHCI_PORT_ACTIVE:
+		pp->active_jiffies +=3D jiffies_delta;
+		break;
+	case AHCI_PORT_PARTIAL:
+		pp->partial_jiffies +=3D jiffies_delta;
+		break;
+	case AHCI_PORT_SLUMBER:
+		pp->slumber_jiffies +=3D jiffies_delta;
+		break;
+	case AHCI_PORT_DEVSLP:
+		pp->devslp_jiffies +=3D jiffies_delta;
+		break;
+	default:
+		break;
+	}
+	pp->previous_state =3D new_state;
+	pp->previous_jiffies =3D new_jiffies;
+}
+
+static ssize_t ahci_alpm_show_active(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+	struct ata_port *ap =3D ata_shost_to_port(shost);
+	struct ahci_port_priv *pp;
+
+	if (!ap || ata_port_is_dummy(ap))
+		return -EINVAL;
+
+	pp =3D ap->private_data;
+	account_alpm_stats(ap);
+
+	return sprintf(buf, "%u\n", jiffies_to_msecs(pp->active_jiffies));
+}
+
+static ssize_t ahci_alpm_show_partial(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+	struct ata_port *ap =3D ata_shost_to_port(shost);
+	struct ahci_port_priv *pp;
+
+	if (!ap || ata_port_is_dummy(ap))
+		return -EINVAL;
+
+	pp =3D ap->private_data;
+	account_alpm_stats(ap);
+
+	return sprintf(buf, "%u\n", jiffies_to_msecs(pp->partial_jiffies));
+}
+
+static ssize_t ahci_alpm_show_slumber(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+	struct ata_port *ap =3D ata_shost_to_port(shost);
+	struct ahci_port_priv *pp;
+
+	if (!ap || ata_port_is_dummy(ap))
+		return -EINVAL;
+
+	pp =3D ap->private_data;
+	account_alpm_stats(ap);
+
+	return sprintf(buf, "%u\n", jiffies_to_msecs(pp->slumber_jiffies));
+}
+
+static ssize_t ahci_alpm_show_devslp(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+	struct ata_port *ap =3D ata_shost_to_port(shost);
+	struct ahci_port_priv *pp;
+
+	if (!ap || ata_port_is_dummy(ap))
+		return -EINVAL;
+
+	pp =3D ap->private_data;
+	account_alpm_stats(ap);
+
+	return sprintf(buf, "%u\n", jiffies_to_msecs(pp->devslp_jiffies));
+}
+
+static ssize_t ahci_alpm_show_accounting(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+	struct ata_port *ap =3D ata_shost_to_port(shost);
+	struct ahci_port_priv *pp;
+
+	if (!ap || ata_port_is_dummy(ap))
+		return -EINVAL;
+
+	pp =3D ap->private_data;
+
+	return sprintf(buf, "%u\n", pp->accounting_active);
+}
+
+static ssize_t ahci_alpm_set_accounting(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	unsigned long flags;
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+	struct ata_port *ap =3D ata_shost_to_port(shost);
+	struct ahci_port_priv *pp;
+	void __iomem *port_mmio;
+
+	if (!ap || ata_port_is_dummy(ap))
+		return 1;
+
+	pp =3D ap->private_data;
+	port_mmio =3D ahci_port_base(ap);
+
+	if (!pp)
+		return 1;
+	if (buf[0] =3D=3D '0')
+		pp->accounting_active =3D 0;
+	if (buf[0] =3D=3D '1')
+		pp->accounting_active =3D 1;
+
+	/* we need to enable the PHYRDY interrupt when we want accounting */
+	if (pp->accounting_active) {
+		spin_lock_irqsave(ap->lock, flags);
+		pp->intr_mask |=3D PORT_IRQ_PHYRDY;
+		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+	return count;
+}
+
 static ssize_t ahci_show_host_caps(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -679,9 +880,14 @@ static int ahci_set_lpm(struct ata_link *link, enum at=
a_lpm_policy policy,
 		 * Disable interrupts on Phy Ready. This keeps us from
 		 * getting woken up due to spurious phy ready
 		 * interrupts.
+		 *
+		 * However, when accounting_active is set, we do want
+		 * the interrupts for accounting purposes.
 		 */
-		pp->intr_mask &=3D ~PORT_IRQ_PHYRDY;
-		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+		if (!pp->accounting_active) {
+			pp->intr_mask &=3D ~PORT_IRQ_PHYRDY;
+			writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+		}
=20
 		sata_link_scr_lpm(link, policy, false);
 	}
@@ -1675,6 +1881,7 @@ static void ahci_port_intr(struct ata_port *ap)
 	/* if LPM is enabled, PHYRDY doesn't mean anything */
 	if (ap->link.lpm_policy > ATA_LPM_MAX_POWER) {
 		status &=3D ~PORT_IRQ_PHYRDY;
+		account_alpm_stats(ap);
 		ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
 	}
=20

--=20
dwmw2

--=-0WhkqUfuROxe/G5PS+I1
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIUbjCCBjQw
ggQcoAMCAQICAR4wDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0
Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxKTAn
BgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3MTAyNDIxMDE1NVoX
DTE3MTAyNDIxMDE1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSsw
KQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFy
dENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMcJg8zOLdgasSmkLhOrlr6KMoOMpohBllVHrdRvEg/q6r8jR+EK
75xCGhR8ToREoqe7zM9/UnC6TS2y9UKTpT1v7RSMzR0t6ndl0TWBuUr/UXBhPk+Kmy7bI4yW4urC
+y7P3/1/X7U8ocb8VpH/Clt+4iq7nirMcNh6qJR+xjOhV+VHzQMALuGYn5KZmc1NbJQYclsGkDxD
z2UbFqE2+6vIZoL+jb9x4Pa5gNf1TwSDkOkikZB1xtB4ZqtXThaABSONdfmv/Z1pua3FYxnCFmdr
/+N2JLKutIxMYqQOJebr/f/h5t95m4JgrM3Y/w7YX9d7YAL9jvN4SydHsU6n65cCAwEAAaOCAa0w
ggGpMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBRTcu2SnODaywFc
fH6WNU7y1LhRgjAfBgNVHSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRa
MFgwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYh
aHR0cDovL3d3dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6
Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5j
b20vc2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBAAqDCH14qywG
XLhjjF6uHLkjd02hcdh9hrw+VUsv+q1eeQWB21jWj3kJ96AUlPCoEGZ/ynJNScWy6QMVQjbbMXlt
UfO4n4bGGdKo3awPWp61tjAFgraLJgDk+DsSvUD6EowjMTNx25GQgyYJ5RPIzKKR9tQW8gGK+2+R
HxkUCTbYFnL6kl8Ch507rUdPPipJ9CgJFws3kDS3gOS5WFMxcjO5DwKfKSETEPrHh7p5shuuNktv
sv6hxHTLhiMKX893gxdT3XLS9OKmCv87vkINQcNEcIIoFWbP9HORz9v3vQwR4e3ksLc2JZOAFK+s
sS5XMEoznzpihEP0PLc4dCBYjbvSD7kxgDwZ+Aj8Q9PkbvE9sIPP7ON0fz095HdThKjiVJe6vofq
+n6b1NBc8XdrQvBmunwxD5nvtTW4vtN6VY7mUCmxsCieuoBJ9OlqmsVWQvifIYf40dJPZkk9YgGT
zWLpXDSfLSplbY2LL9C9U0ptvjcDjefLTvqSFc7tw1sEhF0n/qpA2r0GpvkLRDmcSwVyPvmjFBGq
Up/pNy8ZuPGQmHwFi2/14+xeSUDG2bwnsYJQG2EdJCB6luQ57GEnTA/yKZSTKI8dDQa8Sd3zfXb1
9mOgSF0bBdXbuKhEpuP9wirslFe6fQ1t5j5R0xi72MZ8ikMu1RQZKCyDbMwazlHiMIIHFzCCBf+g
AwIBAgIDBCZ6MA0GCSqGSIb3DQEBBQUAMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRD
b20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYG
A1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwHhcN
MTIwNTAxMTI1ODI3WhcNMTMwNTAzMTEzNzIwWjBdMRkwFwYDVQQNExA4Y1VOSzUzMTc0ODRYRjk3
MRwwGgYDVQQDDBNkd213MkBpbmZyYWRlYWQub3JnMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZy
YWRlYWQub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyYe7wo6MrtrB4uIGGbrY
4IifY/Xsq22pSv605yganL0+uyUdd8rCjrYlH6Q/ra5TVJCQFTgzaepkuqPQc79DC/Cxmzm6Qo+s
wLZy868oFsccsVokL2bPAWIPaRXfNPJKkYR1FTWQfZpWJVQmT+sPf1XFUullVBAK+d9RztopyacI
xWoZ/W/Cmv7mseQbttYTtGKJa0btX73nsQRWl6SgErWXo59zg9friCLTy1GXMXJYB8H+PtnuwX0w
MrAvWDdX1ABgIlA17W3FraCn0eW15ZM46eyu0/amGzJZNtemCWF73P7BAijzeV1jNmiJFXdZ0DT0
w+hmtMO9PxdDUyt78QIDAQABo4IDrjCCA6owCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBTkfe5UOr3PcirsjApibyyUEfsyRzAf
BgNVHSMEGDAWgBRTcu2SnODaywFcfH6WNU7y1LhRgjAeBgNVHREEFzAVgRNkd213MkBpbmZyYWRl
YWQub3JnMIICIQYDVR0gBIICGDCCAhQwggIQBgsrBgEEAYG1NwECAjCCAf8wLgYIKwYBBQUHAgEW
Imh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0
Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdhcyBp
c3N1ZWQgYWNjb3JkaW5nIHRvIHRoZSBDbGFzcyAxIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRzIG9m
IHRoZSBTdGFydENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBw
dXJwb3NlIGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMIGc
BggrBgEFBQcCAjCBjzAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgECGmRM
aWFiaWxpdHkgYW5kIHdhcnJhbnRpZXMgYXJlIGxpbWl0ZWQhIFNlZSBzZWN0aW9uICJMZWdhbCBh
bmQgTGltaXRhdGlvbnMiIG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3kuMDYGA1UdHwQvMC0wK6Ap
oCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUxLWNybC5jcmwwgY4GCCsGAQUFBwEBBIGB
MH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIvY2xhc3MxL2NsaWVu
dC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2VydHMvc3ViLmNsYXNz
MS5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tLzANBgkq
hkiG9w0BAQUFAAOCAQEAqDU1FKifNtCFJbLnvOi1BLRfk7mut55PMtPSZLJ4/AnG7AjmJnbBI4U5
DELwvVq3mIpwUpGqZUkqkZMEfBPIbfq517UZB3h4iANtqif+ULfTLhg5XgcK5eF8/T6EtX2c3epq
ylARdleCbj/0FwiUDvPlTsA6PIN4SCekjRLgjKERrL3heFz+Hteq1rtMAvMkNuyL0/0ijyyg2y45
NASAl2Afl9SLes/fnoh9nBwzfNQfb6qDYUFpnglfpGrq/0b1NtaOUb2z1SR+H1tKlb8bVJJIdvpu
mEi27kSRIhzk3h30uTfKkKetgy++ouyldxZ7KZ0PuoLQrBy465EoQLosETCCBxcwggX/oAMCAQIC
AwQmejANBgkqhkiG9w0BAQUFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0
ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMT
L1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBMB4XDTEyMDUw
MTEyNTgyN1oXDTEzMDUwMzExMzcyMFowXTEZMBcGA1UEDRMQOGNVTks1MzE3NDg0WEY5NzEcMBoG
A1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFk
Lm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMmHu8KOjK7aweLiBhm62OCIn2P1
7KttqUr+tOcoGpy9PrslHXfKwo62JR+kP62uU1SQkBU4M2nqZLqj0HO/QwvwsZs5ukKPrMC2cvOv
KBbHHLFaJC9mzwFiD2kV3zTySpGEdRU1kH2aViVUJk/rD39VxVLpZVQQCvnfUc7aKcmnCMVqGf1v
wpr+5rHkG7bWE7RiiWtG7V+957EEVpekoBK1l6Ofc4PX64gi08tRlzFyWAfB/j7Z7sF9MDKwL1g3
V9QAYCJQNe1txa2gp9HlteWTOOnsrtP2phsyWTbXpglhe9z+wQIo83ldYzZoiRV3WdA09MPoZrTD
vT8XQ1Mre/ECAwEAAaOCA64wggOqMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQU5H3uVDq9z3Iq7IwKYm8slBH7MkcwHwYDVR0j
BBgwFoAUU3Ltkpzg2ssBXHx+ljVO8tS4UYIwHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiEGA1UdIASCAhgwggIUMIICEAYLKwYBBAGBtTcBAgIwggH/MC4GCCsGAQUFBwIBFiJodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMDQGCCsGAQUFBwIBFihodHRwOi8vd3d3LnN0
YXJ0c3NsLmNvbS9pbnRlcm1lZGlhdGUucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBTdGFydENvbSBD
ZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0aWZpY2F0ZSB3YXMgaXNzdWVk
IGFjY29yZGluZyB0byB0aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJlcXVpcmVtZW50cyBvZiB0aGUg
U3RhcnRDb20gQ0EgcG9saWN5LCByZWxpYW5jZSBvbmx5IGZvciB0aGUgaW50ZW5kZWQgcHVycG9z
ZSBpbiBjb21wbGlhbmNlIG9mIHRoZSByZWx5aW5nIHBhcnR5IG9ibGlnYXRpb25zLjCBnAYIKwYB
BQUHAgIwgY8wJxYgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwAwIBAhpkTGlhYmls
aXR5IGFuZCB3YXJyYW50aWVzIGFyZSBsaW1pdGVkISBTZWUgc2VjdGlvbiAiTGVnYWwgYW5kIExp
bWl0YXRpb25zIiBvZiB0aGUgU3RhcnRDb20gQ0EgcG9saWN5LjA2BgNVHR8ELzAtMCugKaAnhiVo
dHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9jcnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkG
CCsGAQUFBzABhi1odHRwOi8vb2NzcC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2Ew
QgYIKwYBBQUHMAKGNmh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xp
ZW50LmNhLmNydDAjBgNVHRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcN
AQEFBQADggEBAKg1NRSonzbQhSWy57zotQS0X5O5rreeTzLT0mSyePwJxuwI5iZ2wSOFOQxC8L1a
t5iKcFKRqmVJKpGTBHwTyG36ude1GQd4eIgDbaon/lC30y4YOV4HCuXhfP0+hLV9nN3qaspQEXZX
gm4/9BcIlA7z5U7AOjyDeEgnpI0S4IyhEay94Xhc/h7Xqta7TALzJDbsi9P9Io8soNsuOTQEgJdg
H5fUi3rP356IfZwcM3zUH2+qg2FBaZ4JX6Rq6v9G9TbWjlG9s9Ukfh9bSpW/G1SSSHb6bphItu5E
kSIc5N4d9Lk3ypCnrYMvvqLspXcWeymdD7qC0KwcuOuRKEC6LBExggNvMIIDawIBATCBlDCBjDEL
MAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdp
dGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFy
eSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMEJnowCQYFKw4DAhoFAKCCAa8wGAYJKoZIhvcNAQkD
MQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTMwMzI4MTIyMTE3WjAjBgkqhkiG9w0BCQQx
FgQUHBN8+kbNE3jyxHIG4D6DpiZHNKswgaUGCSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMC
SUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRp
ZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1l
ZGlhdGUgQ2xpZW50IENBAgMEJnowgacGCyqGSIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJ
TDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlm
aWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVk
aWF0ZSBDbGllbnQgQ0ECAwQmejANBgkqhkiG9w0BAQEFAASCAQAujsDIfduOWSQGyPomoujQ86t4
47ys5QWx1F5FYjm/YiTMJ2fz7IC+7fYZ+BcelG9MYboj7qSCbphYXO1mnLVI3P0A6Z7zqUcTCmOs
q3vTuZyZUw4rqVLHYXFWykwdWpkOMghlD4xbxTQvVKeL2EmgnLj8eNej9Cwk81nGrLs44oNXppjK
bq/48vR57IooD7k9oUxiivDsF7zVmKSCpf9q+/9KwDXoFzxZgI5oREYLZn8guBzkYSpNEAiQ03BA
A0NhaLKHI8D3HVGOZmpzLGCGIi1WyXTLtvhsqGoT9LjiE5STlr/FtvSfoEJtOcVODzis57qNYcrN
VPUoyKupUcK3AAAAAAAA


--=-0WhkqUfuROxe/G5PS+I1--

