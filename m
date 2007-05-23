From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [BUG] 2.6.21.1: ide-pci is not finding ide controller.
Date: Wed, 23 May 2007 17:06:13 -0400
Message-ID: <4654ACC5.1030908@redhat.com>
References: <20070523201118.GZ5921@austin.ibm.com> <20070523212425.68897280@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:39561 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756100AbXEWVGe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 May 2007 17:06:34 -0400
In-Reply-To: <20070523212425.68897280@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linas Vepstas <linas@austin.ibm.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/23/2007 04:24 PM, Alan Cox wrote:
> On Wed, 23 May 2007 15:11:18 -0500
> linas@austin.ibm.com (Linas Vepstas) wrote:
> 
>> I've got a rather old x86 box that I'm booting 2.6.21.1 on;
>> this kernel is not finding an ide controller on it. 
> 
> HPT366 fixes were posted here earlier. It doesn't in fact have reliable
> enable bits.

http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fdb0d72be4decaade6cedb5012ddd679a4817b5f

hpt366: don't check enablebits for HPT36x
