From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: Promise SATA TX4 300 port timeout with sata_promise in 2.6.22,
   kernel panic in 2.6.23
Date: Mon, 12 Nov 2007 20:59:47 +0100
Message-ID: <4738B0B3.1090708@how.dk>
References: <6f048fc10711100443y6e9982b9jc00b3740f0a44d79@mail.gmail.com> <4737D2A3.6010103@gmail.com> <fh93nq$uif$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepc.post.tele.dk ([195.41.46.237]:40082 "EHLO
	pfepc.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325AbXKLT7x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 14:59:53 -0500
In-Reply-To: <fh93nq$uif$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patric Karlsson <patric@ce.chalmers.se>
Cc: linux-ide@vger.kernel.org

Hi Patric & list,

Just for the record:

A while ago I wrote SATA TX4 300 with 2.6.23.1 was stable but recently I 
had to correct it to "a lot more stable but not perfect", see 
http://marc.info/?l=linux-ide&m=119465285225569&w=2

(yes it still locks up hard but not very often).

I look forward to testing 2.6.24 with the workaround for the Asic 
hardware issue :-)


Best regards,

Peter

Patric Karlsson wrote:
> Although I'm currently running a TX4 myself in 3Gbit mode with 2.6.23.1, 
>  I'm waiting for 2.6.24 to reach stable until I try it out myself.
> 2.6.23.1 seemed to fix the hard-lock when it tried to reset the card 
> tho, so now I just get a few errors about "soft resetting" in the logs. 
> No data loss.
> 
> /Patric

