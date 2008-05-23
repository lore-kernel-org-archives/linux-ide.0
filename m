From: "Brian & Chamaigne Scamman" <scammanbc@earthlink.net>
Subject: RE: [PATCHSET #upstream-fixes] git tree available
Date: Thu, 22 May 2008 20:49:04 -0400
Message-ID: <00ee01c8bc6e$cc9ee910$6917a8c0@parents>
References: <12111273141039-git-send-email-htejun@gmail.com> <48305961.2050509@gmail.com> <006501c8ba19$c1f53340$6917a8c0@parents> <48323E4F.3050806@rtr.ca> <4832535B.1080505@gmail.com> <483256FF.1010200@gmail.com> <00a501c8bae2$7815f7e0$6917a8c0@parents> <4833AC14.5090207@gmail.com> <00b901c8bb7a$caaa1ed0$6917a8c0@parents> <4834C101.70005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-scoter.atl.sa.earthlink.net ([209.86.89.67]:55722 "EHLO
	elasmtp-scoter.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755687AbYEWAtF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 May 2008 20:49:05 -0400
In-Reply-To: <4834C101.70005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: 'Mark Lord' <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
>Can you please put ssleep(5) right after the first ata_do_reset() call 
>in drivers/ata/libata-eh.c::ata_eh_reset() and see whether the problem 
>goes away?

This actually caused more problems. The "failed to IDENTIFY (I/O error,
err_mask=0x11)" was still printed, plus there was a 5 second delay for each
port on the PMP during each of the 3 attempts to read the drive. In the end,
neither of the two SSD drives I tried ended up working. Changing ssleep(5)
to msleep(5) didn't remove the IDENTIFY errors, but still allowed the drives
to work.

Is there anyway to control the length of the reset pulse? I've heard that
some of the SSD's require the reset pulse to be held longer than normal.

-Brian

