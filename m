From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: siimage.c -serious- error fixed.  Performance/stability issues
      resolved.
Date: Tue, 02 Dec 2003 19:06:24 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FCD2900.1020002@pobox.com>
References: <62929.67.101.15.58.1070362667.squirrel@mail.clanhk.org>    <200312022016.13725.bzolnier@elka.pw.edu.pl> <33385.209.163.161.49.1070400815.squirrel@mail.clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17835 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264378AbTLCAGm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Dec 2003 19:06:42 -0500
In-Reply-To: <33385.209.163.161.49.1070400815.squirrel@mail.clanhk.org>
List-Id: linux-ide@vger.kernel.org
To: Ryan Earl <heretic@clanhk.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Ryan Earl wrote:
> The 15KB request buffer "fix"--*ahem* workaround--never addressed the real
> issue.  You want to get rid of all the 15KB hoocus-poocus.  All that does
> is kill your disk performance, it never solved the problem, merely made
> your system more stable with the problem still around.  Essentially, you
> should never have that buffer set to 15KB and with this fix all that noise
> should just disappear from the driver/kernel.

Not correct.

As has been discussed many times, with certain Seagate drives,

	sector_count % 15 == 1 && sector_count != 1

causes failure.

This is what the 15KB limit addresses.  Read libata SII driver for more 
info.

	Jeff


