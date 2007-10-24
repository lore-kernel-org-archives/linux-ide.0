From: David Miller <davem@davemloft.net>
Subject: Re: [patch] PCI: disable MSI on more ATI NorthBridges
Date: Tue, 23 Oct 2007 19:46:38 -0700 (PDT)
Message-ID: <20071023.194638.105428071.davem@davemloft.net>
References: <20071022.171318.104036671.davem@davemloft.net>
	<471DC66D.6000909@garzik.org>
	<20071023.030622.74744677.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756359AbXJXCq3@vger.kernel.org>
In-Reply-To: <20071023.030622.74744677.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: jeff@garzik.org
Cc: barkalow@iabervon.org, linas@austin.ibm.com, chunhao.huang@hotmail.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, brice@myri.com
List-Id: linux-ide@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 23 Oct 2007 03:06:22 -0700 (PDT)

> Ok, it seems I've sort-of self-nominated myself to implement
> this so I'll try to work on it tomorrow :-)

I have a working implementation, fully tested on a machine
with Tigon3 ethernet chips that have the quirk in question.

Patch set coming up next.
