From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Testing patch for ALi PATA - fixes hopefully for the problems
 with ATAPI DMA
Date: Wed, 28 Mar 2007 23:41:51 +0100
Message-ID: <20070328234151.312ef2c8@the-village.bc.nu>
References: <20070327190248.01bc7e5c@the-village.bc.nu>
	<df47b87a0703281423q70d6ffd3l107bf84c325dec32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40921 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752985AbXC1ViD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 17:38:03 -0400
In-Reply-To: <df47b87a0703281423q70d6ffd3l107bf84c325dec32@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ioan Ionita <opslynx@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 28 Mar 2007 17:23:08 -0400
"Ioan Ionita" <opslynx@gmail.com> wrote:

> On 3/27/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >
> >
> > This implements two things at driver level which are implemented
> > implicitly by the old IDE layer
> >
> > - Only doing sector sized ATAPI I/O via DMA
> > - Alway writing the size values
> 
> 
> Is there a similar approach for SIS PATA ATAPI?

I'm not aware of any similar limit in the SiS hardware but you can
certainly modify the patch and apply it in the same way to the SiS driver
and see what happens
