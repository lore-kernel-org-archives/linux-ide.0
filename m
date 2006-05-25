From: Tejun Heo <htejun@gmail.com>
Subject: Re: SiI3124 + SiI3726 pm
Date: Wed, 24 May 2006 22:07:04 -0700
Message-ID: <44753B78.4090802@gmail.com>
References: <89d273ba0605242046x3d19dd06h74885048f229d519@mail.gmail.com> <89d273ba0605242202l354ec106w22bccf649e5e1dfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000900000401060701000409"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:19926 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965033AbWEYFHQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 May 2006 01:07:16 -0400
Received: by wr-out-0506.google.com with SMTP id i7so52054wra
        for <linux-ide@vger.kernel.org>; Wed, 24 May 2006 22:07:15 -0700 (PDT)
In-Reply-To: <89d273ba0605242202l354ec106w22bccf649e5e1dfc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?J=E9r=F4me_VUARAND?= <jerome.vuarand@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000900000401060701000409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Jérôme VUARAND wrote:
> I just realised after the mail that the driver was really thinking
> there are 6 ports on the pm, since it's testing ata3.05 and ata4.05.
> These don't exist and generate errors. There's a bug somewhere and
> here is a workaround I made quickly to have correct enumeration
> behaviour (I hope no automatic process parse mails on this mailing
> list for patches, coz this one is not really clean) :

Can you try the attached patch?

-- 
tejun

--------------000900000401060701000409
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/libata-pm.c b/drivers/scsi/libata-pm.c
index 002d8b2..7a56ab7 100644
--- a/drivers/scsi/libata-pm.c
+++ b/drivers/scsi/libata-pm.c
@@ -327,6 +327,14 @@ static void ata_pm_quirks(u32 *gscr, int
 		*nr_ports -= 2;
 		*link_flags |= ATA_LFLAG_HRST_TO_RESUME;
 	}
+
+	/* Sil3726 reports one extra port and needs hardreset to
+	 * resume PM link.
+	 */
+	if (vendor == 0x1095 && devid == 0x3726) {
+		*nr_ports -= 1;
+		*link_flags |= ATA_LFLAG_HRST_TO_RESUME;
+	}
 }
 
 static int ata_pm_configure(struct ata_device *dev, int *r_nr_ports,

--------------000900000401060701000409--
