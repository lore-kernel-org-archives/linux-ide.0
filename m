From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_marvell woes
Date: Mon, 29 Sep 2008 10:09:57 +0100
Message-ID: <20080929100957.7cf41fdf@lxorguk.ukuu.org.uk>
References: <3c1bc2140809281827h2154039rec8e65482e54a0f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40918 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752062AbYI2JJ7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 05:09:59 -0400
In-Reply-To: <3c1bc2140809281827h2154039rec8e65482e54a0f4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Stoltenberg <d3matt@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 28 Sep 2008 20:27:52 -0500
"Matthew Stoltenberg" <d3matt@gmail.com> wrote:

> Hey Alan, Jeff, and the linux-ide ML,
> 
> I'm having trouble with a Marvell pata controller.  It's on an Asus
> P5Q PRO.  It's an intel P45 based board with an added PATA controller.
>  The manual (and website) says that the chip a Marvell 88SE6111.

Known bug. Should be fixed in 2.6.27rc. Jeff merged some stuff which broke
the PATA support on the Marvell chips. 2.6.27 merges some changes so that
you now get AHCI if you are using just the SATA ports (best choice), or
pata_marvell if you are using the PATA port as well.


Alan
