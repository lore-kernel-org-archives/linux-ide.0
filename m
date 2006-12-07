From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: CDROM drive not found when booting using new libata code
Date: Thu, 7 Dec 2006 10:55:25 +0000
Message-ID: <20061207105525.4ebb4547@localhost.localdomain>
References: <20060924221020.GB2080@artsapartment.org>
	<4562C65C.2010802@gmail.com>
	<20061206181652.GA3107@artsapartment.org>
	<45779852.1030909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35820 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1032012AbWLGKsM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Dec 2006 05:48:12 -0500
In-Reply-To: <45779852.1030909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Art Haas <ahaas@airmail.net>, linux-ide@vger.kernel.org

On Thu, 07 Dec 2006 13:28:02 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Please test the attached patch.

That should be getting done automatically by the driver and used to work
with the old eh/probe code. It does rely on having done the initial PIO0
identify of both devices and the mode decision being made before mode
setting functions are called however, and that is/was documented as a
guarantee, and is relied upon all over.

Definitely worth testing Art, especially if it shows something up.

Tejun: pata_amd does the timing merges itself both for 8bit which is
shared and in the timing compute for the DMA cases. Also the other
pattern to these reports is ATAPI, although that might I guess be a
symptom of "slave". 

The other problem is that mmio bus reset is broken, but the AMD always
uses PIO cycles so that shouldn't be involved.

Alan (still baffled by this one)

