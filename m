From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Marvell SATA fixes v2
Date: Wed, 23 Nov 2005 16:40:57 -0500
Message-ID: <4384E1E9.2070309@pobox.com>
References: <437D2DED.5030602@pobox.com>	<Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de>	<20051118215209.GA9425@havoc.gtf.org> <52veyp39hs.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932547AbVKWVlG@vger.kernel.org>
In-Reply-To: <52veyp39hs.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland Dreier <rolandd@cisco.com>
Cc: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Roland Dreier wrote:
>     Jeff> Yes, for both 50xx and 60xx, I had to turn off MSI in order
>     Jeff> to get sata_mv to work...
> 
> Sounds like MSI is broken in the Marvell chip.  This is exactly the

No, it could be any one of

* broken Marvell chip
* broken system
* driver bug

It hasn't been narrowed down yet.

	Jeff
