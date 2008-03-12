From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Remove obsoleted "idex=noprobe" kernel parameter
Date: Wed, 12 Mar 2008 10:31:04 +0000
Message-ID: <20080312103104.6daeebec@the-village.bc.nu>
References: <Pine.LNX.4.64.0803120418580.12249@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zux006-051-205.adsl.green.ch ([81.6.51.205]:16995 "EHLO
	the-village.bc.nu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751206AbYCLLsp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 07:48:45 -0400
In-Reply-To: <Pine.LNX.4.64.0803120418580.12249@Soyuz-KT.TeNet.Odessa.UA>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

On Wed, 12 Mar 2008 04:47:59 +0200 (EET)
"Rus V. Brushkoff" <rus@SoyuzKT.Od.UA> wrote:

> 
>  	Hi,
> 
>   Why this option is obsoleted ? It can be used on many systems when Linux 
> still tries to detect disabled in the BIOS IDE controller - you may 
> significantly reduce boot time, without bunch of the "ide reset succeed" 

It's still needed on some PC systems as well. Just use libata instead,
and for the cases we need to fix up probing let the libata team know and
we'll do our best to make it automated. Even for old IDE automating this
sort of stuff is better when possible.

>   Its pitifully, especial for embedded people, that Linux becoming less 
> configurable system ;(

drivers/ide - not Linux
 
