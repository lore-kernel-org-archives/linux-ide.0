From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 19 May 2004 16:27:29 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085005649.3141.10.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482  
	8		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.32
	 11	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com><1084920024.3191.8.ca
	 mel@patibmrh9>  <40AAA0BA.9040307@pobox.com><1085005467.3141.5.camel@patib
	mrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:20897 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264660AbUESW1k
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2004 18:27:40 -0400
In-Reply-To: <1085005467.3141.5.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> I lost my display & mouse & keyboard.

And /var/log/messages caught nothing:

kernel: ata_device_add: EXIT, returning 2
kernel: piix_init: done
syslogd 1.4.1: restart.
syslog: syslogd startup succeeded

> @@ -137,7 +137,7 @@ void ata_to_sense_error(struct ata_queue
> ...
> @@ -926,7 +926,7 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
> -	cmd->sense_buffer[0] = 0x70;
> +	cmd->sense_buffer[0] = 0xf0;

We're setting (bytes[0] & x80) INFO "Valid" why?

In hopes of soon filling in bytes[2:3:4:5] "INFO" with a nonzero
LBA-in-error?

Pat LaVarre


