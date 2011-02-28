From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Intel ICH9M bug : sata unusable with usbserial
Date: Mon, 28 Feb 2011 15:05:53 +0000
Message-ID: <20110228150553.66d02bc7@lxorguk.ukuu.org.uk>
References: <20110228140149.GA18189@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39507 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754487Ab1B1PF4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2011 10:05:56 -0500
In-Reply-To: <20110228140149.GA18189@frolo.macqel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philippe De Muyter <phdm@macqel.be>
Cc: linux-ide@vger.kernel.org

> The running running processes keep running, and the GPS listening process
> continues to get messages from the USB GPS receiver each second.
> 
> Is that a known (an fixed) problem ?

No and I doubt it is a general problem or it would have been reported
long ago. Looks like your hard drive just dropped offline - power
problems perhaps ?
