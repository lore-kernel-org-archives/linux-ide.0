From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Thu, 14 Apr 2011 20:28:36 -0400
Message-ID: <4DA79134.1010508@teksavvy.com>
References: <C1438B59050E1B4C9482FF3266AD6BA32C7493557A@gretna.indigovision.com> <C1438B59050E1B4C9482FF3266AD6BA32C7493559F@gretna.indigovision.com> <4D9CD275.9000002@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C749358D0@gretna.indigovision.com> <4D9FACC9.7020200@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C772D9EB1@gretna.indigovision.com> <4DA5BCF3.5080205@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C772DA491@gretna.indigovision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:8967 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754817Ab1DOA2k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Apr 2011 20:28:40 -0400
In-Reply-To: <C1438B59050E1B4C9482FF3266AD6BA32C772DA491@gretna.indigovision.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Stenning <b.stenning@indigovision.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 11-04-14 12:50 PM, Bruce Stenning wrote:
..
> I have tried the patch out and I was able to reproduce the port lockup with it.

Bummer.

> I also tried out my tracing in writelfl (without any other changes) and I was
> able to lock up a port without any apparent unusual changes to the register
> containing the irq masks.  Are there other routes to disabling the irqs?


Mmm.. presumably you are NOT using MSI interrupts, right?

