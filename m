Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457312E6D
	for <linux-ide@vger.kernel.org>; Tue, 18 Jun 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724954; cv=none; b=TUZGgAL6nbIfTfGN+EikhQETMvQhIQNpOV4tIPPRxpzLk7T6qt8s/jtrEfvN8wuXMSe+cfmvxA2QP/haaaWmXglp2XPs2EZGrIPgyp4xGj2MxYYrw5QEm0jSPLRHMweBH1I8b2iQO3yIe/avoCHRaWwzSbOz1F/PeHQFFwht8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724954; c=relaxed/simple;
	bh=D7Y0iZ5CY3rPzIS9t8KyizS5G30+PdjdGwab0R/FRsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUIXUuHwSkjwpB8+CPnjt1NOaprdv+TA5HWWR0vY46ltzIkcfCz3t51Qm3ywN4IgNIbzvR0mKuAWh7P8mOE+Vv3+B/Iqsd5wQAqZHZRnwnYR+qQCLFIVcZrwNRuq6O3WhqPHJgJcZqxlG3gnSdiCLYjPadmaGuTIyMqUeTdQ+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNILCYMP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNILCYMP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEC2C4AF1C;
	Tue, 18 Jun 2024 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718724953;
	bh=D7Y0iZ5CY3rPzIS9t8KyizS5G30+PdjdGwab0R/FRsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNILCYMPu7KrHwmCDwlcqUNiBuIDl81T0cPEwMFm3v41V3n1XWFKefaHMYaT6+3QB
	 e3k0R2GSA5jEepjt6DZKaoQZtj0UepfC9HzAJL4RoFMA8xF78sLtoVZUNH3tGpiibP
	 5PWXkafdE9jrUWmZdx6oukh7/R61o0n3PsOKm5OBtJpryzdiLUCmSKErDvefJSeQph
	 x3E/4JBcfz/9DCPy4A+BMofEvUmuoj6QjpOBnz5ZhfPUtBwpdcUKwpHpJxbTGJ5k5Y
	 5HWzw/8W49593HxKSmdKfQjLUNifDnLMt/txiGuSbtrLyASWC94RU2tGB5FkL7TXDp
	 zrRObzxkjd6kA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 1/5] ata: libata-core: Remove support for decreasing the number of ports
Date: Tue, 18 Jun 2024 17:35:39 +0200
Message-ID: <20240618153537.2687621-8-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618153537.2687621-7-cassel@kernel.org>
References: <20240618153537.2687621-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3750; i=cassel@kernel.org; h=from:subject; bh=D7Y0iZ5CY3rPzIS9t8KyizS5G30+PdjdGwab0R/FRsA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIKV3rVeWa968w02ZxnvSbMca21xJrozz9OTd3a4bd+z dyHTwpDO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRLk6Gv/KtOVziC/v9LWqY bl7mORxSe6nuaFLmQSXJWR/3B965n8bw36uiS+3i/Yy/MxgawtftLGMpXuZia8IdFpx+Y+uWN1f 4+AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit f31871951b38 ("libata: separate out ata_host_alloc() and
ata_host_register()") added ata_host_alloc(), where the API allowed
a LLD to overallocate the number of ports supplied to ata_host_alloc(),
as long as the LLD decreased host->n_ports before calling
ata_host_register().

However, this functionally has never ever been used by a single LLD.

Because of the current API design, the assignment of ap->print_id is
deferred until registration time, which is bad, because that means that
the ata_port_*() print functions cannot be used by a LLD until after
registration time, which means that a LLD is forced to use a print
function that is non-port specific, even for a port specific error.

Remove the support for decreasing the number of ports, such that it will
be possible to assign ap->print_id earlier.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e1bf8a19b3c8..0dc6e18bf492 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5541,24 +5541,19 @@ EXPORT_SYMBOL_GPL(ata_host_put);
 /**
  *	ata_host_alloc - allocate and init basic ATA host resources
  *	@dev: generic device this host is associated with
- *	@max_ports: maximum number of ATA ports associated with this host
+ *	@n_ports: the number of ATA ports associated with this host
  *
  *	Allocate and initialize basic ATA host resources.  LLD calls
  *	this function to allocate a host, initializes it fully and
  *	attaches it using ata_host_register().
  *
- *	@max_ports ports are allocated and host->n_ports is
- *	initialized to @max_ports.  The caller is allowed to decrease
- *	host->n_ports before calling ata_host_register().  The unused
- *	ports will be automatically freed on registration.
- *
  *	RETURNS:
  *	Allocate ATA host on success, NULL on failure.
  *
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  */
-struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
+struct ata_host *ata_host_alloc(struct device *dev, int n_ports)
 {
 	struct ata_host *host;
 	size_t sz;
@@ -5566,7 +5561,7 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	void *dr;
 
 	/* alloc a container for our list of ATA ports (buses) */
-	sz = sizeof(struct ata_host) + (max_ports + 1) * sizeof(void *);
+	sz = sizeof(struct ata_host) + (n_ports + 1) * sizeof(void *);
 	host = kzalloc(sz, GFP_KERNEL);
 	if (!host)
 		return NULL;
@@ -5584,11 +5579,11 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	spin_lock_init(&host->lock);
 	mutex_init(&host->eh_mutex);
 	host->dev = dev;
-	host->n_ports = max_ports;
+	host->n_ports = n_ports;
 	kref_init(&host->kref);
 
 	/* allocate ports bound to this host */
-	for (i = 0; i < max_ports; i++) {
+	for (i = 0; i < n_ports; i++) {
 		struct ata_port *ap;
 
 		ap = ata_port_alloc(host);
@@ -5899,12 +5894,13 @@ int ata_host_register(struct ata_host *host, const struct scsi_host_template *sh
 		return -EINVAL;
 	}
 
-	/* Blow away unused ports.  This happens when LLD can't
-	 * determine the exact number of ports to allocate at
-	 * allocation time.
+	/*
+	 * For a driver using ata_host_register(), the ports are allocated by
+	 * ata_host_alloc(), which also allocates the host->ports array.
+	 * The number of array elements must match host->n_ports.
 	 */
 	for (i = host->n_ports; host->ports[i]; i++)
-		kfree(host->ports[i]);
+		WARN_ON(host->ports[i]);
 
 	/* give ports names and add SCSI hosts */
 	for (i = 0; i < host->n_ports; i++) {
-- 
2.45.2

