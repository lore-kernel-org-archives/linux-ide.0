From: Philip Armstrong <phil@kantaka.co.uk>
Subject: Re: (fwd) Re: Bug#289770: kernel-image-2.6.10-1-686: 2.6.10 fails to set up DMA on my IBM thinkpad
Date: Wed, 12 Jan 2005 12:02:45 +0000
Message-ID: <20050112120245.GA24839@kantaka.co.uk>
References: <20050111195345.GI2618@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl-217-155-153-11.zen.co.uk ([217.155.153.11]:2986 "EHLO
	217.155.153.11") by vger.kernel.org with ESMTP id S261162AbVALMCr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Jan 2005 07:02:47 -0500
Content-Disposition: inline
In-Reply-To: <20050111195345.GI2618@stro.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: maximilian attems <debian@sternwelten.at>
Cc: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, 289770@bugs.debian.org

On Tue, Jan 11, 2005 at 08:53:45PM +0100, maximilian attems wrote:
> dma on a thinkpad  600E worked for 2.6.8, but didn't since 2.6.9
> also non working 2.6.10.
> 
> -hda: 12594960 sectors (6448 MB) w/460KiB Cache, CHS=13328/15/63, UDMA(33)
> +hda: 12594960 sectors (6448 MB) w/460KiB Cache, CHS=13328/15/63
> 
> could you please look at the following ide dma bug report for piix in
> debian -> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=289770
> full dmesg of both 2.6.8 and 2.6.10 are posted there.

Incidentally, this may be the same bug as Debian bug #284558:

  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=284558

which involves more recent PIIX hardware.

Phil

-- 
http://www.kantaka.co.uk/ .oOo. public key: http://www.kantaka.co.uk/gpg.txt
