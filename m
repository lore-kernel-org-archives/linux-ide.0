From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Marvell SATA fixes v2
Date: Tue, 15 Nov 2005 10:15:24 -0500
Message-ID: <4379FB8C.3050904@pobox.com>
References: <20051114050404.GA18144@havoc.gtf.org> <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de> <4379F31D.4000508@pobox.com> <Pine.LNX.4.63.0511151554330.3015@dingo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932539AbVKOPPc@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511151554330.3015@dingo.iwr.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bogdan Costescu wrote:
> I don't think that this is really what you wanted - you probably wanted 
> the place in libata where insmod stops, but the root FS is on another 
> SATA disk connected to the ICH6, so if I enable DEBUG for libata this 
> controller/disk will log quite a lot, right ?

Correct on all counts :(

	Jeff
