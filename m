From: Tejun Heo <htejun@gmail.com>
Subject: Re: ADS3GX4R5-E IO problem?
Date: Mon, 22 Oct 2007 11:01:17 +0900
Message-ID: <471C046D.8050503@gmail.com>
References: <B22C35D0-A23F-4FBD-9984-0FEC338055DB@illianced.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:11876 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbXJVCBZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Oct 2007 22:01:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1037295rvb
        for <linux-ide@vger.kernel.org>; Sun, 21 Oct 2007 19:01:24 -0700 (PDT)
In-Reply-To: <B22C35D0-A23F-4FBD-9984-0FEC338055DB@illianced.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Didde Brockman <didde.brockman@illianced.com>
Cc: linux-ide@vger.kernel.org

Hello,

Didde Brockman wrote:
> Oct 20 13:49:00 infra kernel: md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for resync.
> Oct 20 13:49:00 infra kernel: md: using 128k window, over a total of 244195904 blocks.
> Oct 20 13:50:37 infra kernel:          res 41/40:00:2e:1c:a1/9d:01:00:00:00/40 Emask 0x409 (media error) <F>
> Oct 20 13:50:37 infra kernel: ata4.00: configured for UDMA/100
> Oct 20 13:50:37 infra kernel: ata4: EH complete

Error messages from libata are truncated there should be more lines
before the line starts with "res".  Please post full dmesg.  From the
above, it seems like a bad drive tho.  Media error indicates that the
drive reported the media (platter) is bad and can't be read or
written.

-- 
tejun
