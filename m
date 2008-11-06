From: Marc Pignat <marc.pignat@hevs.ch>
Subject: Re: [PATCH] pata_pcmcia: another memory card support
Date: Thu, 6 Nov 2008 13:09:26 +0100
Message-ID: <200811061309.26939.marc.pignat@hevs.ch>
References: <200811061144.35556.marc.pignat@hevs.ch> <20081106205522.1c86a44b.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.hevs.ch ([153.109.23.10]:33122 "EHLO mail.hevs.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672AbYKFMJe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Nov 2008 07:09:34 -0500
In-Reply-To: <20081106205522.1c86a44b.komurojun-mbn@nifty.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org

Hi!

On Thursday 06 November 2008, Komuro wrote:
...
> Could you post the output of lspcmcia -vv?

Here it is:
armebs3:~# lspcmcia -vv
Socket 0 Bridge:        [at91_cf]       (bus ID: at91_cf)
        Configuration:  state: on       ready: yes
                        Voltage: 3.3V Vcc: 3.3V Vpp: 0.0V
                        Available IRQs: none
Socket 0 Device 0:      [pata_pcmcia]           (bus ID: 0.0)
        Configuration:  state: on
        Product Name:    512MB Flash Card 55LD017-A2 CFCA217I
        Identification: manf_id: 0x00bf card_id: 0x0001
                        function: 4 (fixed disk)
                        prod_id(1): " 512MB" (0xdc108d0e)
                        prod_id(2): "Flash Card" (0x5a362506)
                        prod_id(3): "55LD017-A2" (0xc0ede6dd)
                        prod_id(4): "CFCA217I" (0x8c1a6afb)
armebs3:~#        
> 
> I think it is better to use "PCMCIA_DEVICE_PROD_ID12"
> instead of "PCMCIA_DEVICE_PROD_ID2"
> 
> > +	PCMCIA_DEVICE_PROD_ID2("Flash Card", 0x5a362506),

I don't want to hardcode the size, however I'm not sure if other size have the
same prod_id2. " 512MB" with the space at the begginning let me hope there is
some card exists with 1024, 2048, ... or anything else in that place.

Best regards

Marc
