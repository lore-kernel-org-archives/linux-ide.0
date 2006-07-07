From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 22/24] jmicron: Jmicron multifunction setup
Date: Fri, 07 Jul 2006 15:50:58 -0400
Message-ID: <44AEBB22.2080503@pobox.com>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk>	<1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361203144-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk>	<1152036122125! 0-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361233826-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361232889-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361243147-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361254139-git-send-email-alan@lxorguk.ukuu.org.uk>	<11520361251284-git-send-email-al
 an@lxorguk.ukuu.org.uk>	<44AE8D08.9070407@pobox.com> <20060707124535.0654e8b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:19073 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932289AbWGGTvB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jul 2006 15:51:01 -0400
In-Reply-To: <20060707124535.0654e8b1.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, alan@redhat.com

Andrew Morton wrote:
> On Fri, 07 Jul 2006 12:34:16 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> ACK patches 19-22
> 
> I found them!
> 
> pata-jmicron-it-works-better-if-you-get-the-file-name-right.patch
> pata-jmicron-further-clean-up.patch
> pata-ata_jmicro-fix-an-escapee.patch
> pata-jmicron-jmicron-multifunction-setup.patch

Hopefully Alan will collapse that down to a single jmicron libata patch.

FWIW the earlier patches in the series should be in 
libata-dev.git#pata-drivers (and thus libata-dev.git#ALL).

	Jeff



