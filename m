From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Bug report (suspend to disk is broken in 2.6.29+ with EIDE drive)
Date: Sat, 01 Aug 2009 12:36:23 -0600
Message-ID: <4A748B27.3000902@gmail.com>
References: <937390.49428.qm@web111003.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f201.google.com ([209.85.216.201]:35558 "EHLO
	mail-px0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbZHASgZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Aug 2009 14:36:25 -0400
In-Reply-To: <937390.49428.qm@web111003.mail.gq1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Watts <akwatts@ymail.com>
Cc: linux-kernel@vger.kernel.org, bzolnier@gmail.com, ide <linux-ide@vger.kernel.org>

On 07/31/2009 12:22 AM, Andrew Watts wrote:
> Description: s2disk worked in 2.6.28 and no longer works in 2.6.30.2
> (s2disk here means: echo disk>  /sys/power/state); screen blanks but
> system hangs.
>
> Bisection reveals that the problem commit has hash:
> 295f00042aaf6b553b5f37348f89bab463d4a469.

That would be:

author	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
	Fri, 2 Jan 2009 15:12:48 +0000 (16:12 +0100)
committer	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
	Fri, 2 Jan 2009 15:12:48 +0000 (16:12 +0100)
commit	295f00042aaf6b553b5f37348f89bab463d4a469
tree	cbd56955f148f0e175d5b6b779c2888bf2645382
parent	ebdab07dad3d3a008e519b0a028e1e1ad5ecaef0

ide: don't execute the next queued command from the hard-IRQ context (v2)

CCing Bart and linux-ide.
