From: 7091@blargh.com
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Wed, 04 Jul 2007 02:26:43 -0700
Message-ID: <courier.468B67D3.000031C8@blargh.com>
References: <courier.4689EFD9.0000589A@blargh.com>
            <468A0E24.7020000@gmail.com>
            <courier.468B005A.0000127A@blargh.com>
            <20070704101835.064bae93@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blargh.com ([24.234.115.147]:55852 "EHLO blargh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754980AbXGDJ0o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jul 2007 05:26:44 -0400
In-Reply-To: <20070704101835.064bae93@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: 7091@blargh.com, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

Alan Cox writes: 

> Not suprised to be honest. We have a large number of reports that are all
> of the following form 
> 
> 	"Nvidia chipset, Silicon Image SATA, corruption" 
> 
> and several reports that BIOS updates fixed it. Unfortunately we don't
> know what the BIOS updates do (or indeed if what they do is board
> specific) or how to work around it otherwise. 
> 
> Alan

Well, that's the thing, and one of the details that may have gotten a little 
lost in the long reply chain. 

The Silicon Image SATA ports on the motherboard work fine. 

Silicon Image SATA ports on addon cards are showing corrutpion. 

I have also flashed the Motherboard BIOS to the newest available version, 
which got the onboard ports, and the addon card got flashed as well. 

:(  A very frustrating problem.
