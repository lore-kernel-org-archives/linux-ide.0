From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Marvell SATA fixes v2
Date: Thu, 17 Nov 2005 20:27:09 -0500
Message-ID: <437D2DED.5030602@pobox.com>
References: <20051114050404.GA18144@havoc.gtf.org> <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de> <4379F31D.4000508@pobox.com> <Pine.LNX.4.63.0511152108140.3015@dingo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932165AbVKRB1S@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511152108140.3015@dingo.iwr.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

See if you can give the latest git tree a try (what will be 
2.6.15-rc1-git6, later tonight).  I think I've killed most of the 
sata_mv bugs, and have it working here on both 50xx and 60xx.

	Jeff
