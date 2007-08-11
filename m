From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] hpt366: UltraDMA filtering for SATA cards
Date: Sat, 11 Aug 2007 21:28:04 +0400
Message-ID: <46BDF1A4.2020902@ru.mvista.com>
References: <200708060008.38077.sshtylyov@ru.mvista.com> <200708090008.10352.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:61338 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751790AbXHKRZx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Aug 2007 13:25:53 -0400
In-Reply-To: <200708090008.10352.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: rah@bash.sh, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>Index: linux-2.6/drivers/ide/pci/hpt366.c
>>===================================================================
>>--- linux-2.6.orig/drivers/ide/pci/hpt366.c
>>+++ linux-2.6/drivers/ide/pci/hpt366.c
[...]
>>+	case HPT372 :
>>+	case HPT372A:
>>+	case HPT372N:
>>+	case HPT374 :
>>+		/*
>>+		 * Check for SATA drive by verifying that the word 93 is 0 and
>>+		 * the drive is ATA-5 or higher compatible.
>>+		 */
>>+		if (id->hw_config == 0 && (id->major_rev_num & 0x7fe0))

> Same check as in ide-iops.c::eighty_ninty_three().

> Would make sense to add ide_id_is_sata_dev() inline to <linux/ide.h>.

    Right in this patch, or a later cleanup?

>>+			return 0x71;
>>+		/* fall thru */
>> 	default:
>> 		return 0x7f;

MBR, Sergei
