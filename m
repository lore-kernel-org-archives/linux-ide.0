From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: problems with sata_nv and MV88SX5081 under 2.6.28, fine
 under2.6.17.6
Date: Wed, 7 Jan 2009 15:45:46 +0000
Message-ID: <20090107154546.07c8bba8@lxorguk.ukuu.org.uk>
References: <1231340005.20422.84.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59841 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760066AbZAGPpc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jan 2009 10:45:32 -0500
In-Reply-To: <1231340005.20422.84.camel@ukabzc383.uk.saic.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Cc: linux-ide@vger.kernel.org

On Wed, 07 Jan 2009 14:53:25 +0000
"Eamonn Hamilton" <EAMONN.HAMILTON@saic.com> wrote:

> Hi,
> 
> I look after a server with a bunch of drives hooked up to two 8 port
> PCI-X sata cards, detected as above.
> 
> The server was running 2.6.17.6 which has sata_mv version 0.7, which
> worked fine. I recently upgraded the kernel to 2.6.18 with version 1.24,
> and started getting

2.6.18 or 2.6.28 ? - if its 2.6.18 then you might want to check if 2.6.28
is ok before doing the work.
