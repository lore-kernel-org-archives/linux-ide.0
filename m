From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/5] Phy: DT binding documentation for Marvell MVEBU SATA
 phy.
Date: Thu, 5 Dec 2013 10:47:04 +0100
Message-ID: <20131205094704.GE10498@lunn.ch>
References: <1386177364-10164-1-git-send-email-andrew@lunn.ch>
 <1386177364-10164-2-git-send-email-andrew@lunn.ch>
 <52A01742.2080405@ti.com>
 <20131205094319.GD10498@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:57170 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154Ab3LEJrM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Dec 2013 04:47:12 -0500
Content-Disposition: inline
In-Reply-To: <20131205094319.GD10498@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

> > > +			compatible = "marvell,mvebu-sata-phy";
> > > +			reg = <0x84000 0x0334>;
> > > +			clocks = <&gate_clk 15>;
> > > +			clock-names = "sata";
> > > +			#phy-cells = <1>;
> > 
> > Is it on purpose that your are having phy-cells value to 1?
> 
> Yes. Each instance only controls one phy.

Ah, sorry, got that wrong. As you say in a later comment, this should
be 0. Will be fixed in v2.

   Thanks
	Andrew

   
