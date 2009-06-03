From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Kernel 2.6.30rc7 limits IDE to UDMA33
Date: Tue, 02 Jun 2009 22:05:28 -0600
Message-ID: <4A25F688.9000407@gmail.com>
References: <c5bd819b0906021525l13ee9282j1fb270e141985f66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:50104 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbZFCEF3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jun 2009 00:05:29 -0400
In-Reply-To: <c5bd819b0906021525l13ee9282j1fb270e141985f66@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grozdan <neutrino8@gmail.com>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

Grozdan wrote:
> Hi,
> 
> I gave today kernel 2.6.30rc7 a spin on my Athlon 64 system and it
> seems there's yet again a problem with libata limiting IDE disks to
> UDMA33 since it thinks that the cable is only 40 wires. My distro
> kernel which is 2.6.27.21 does not have this problem and correctly
> sets my disks to UDMA133. I googled around and it seems in the past
> this was a known problem for some kernels. Any suggestions? :)
> 
> Please cc me as I'm not subscribed to the list

Full dmesg output from bootup would be useful.

CCing linux-ide.
