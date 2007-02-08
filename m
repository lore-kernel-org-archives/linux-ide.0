From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: What's the status of hotplugging a disc on a Promise TX4-controller
Date: Thu, 8 Feb 2007 15:46:26 +0100 (MET)
Message-ID: <200702081446.l18EkQOn010349@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:46327 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423076AbXBHOqn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Feb 2007 09:46:43 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mikpe@it.uu.se, ms@citd.de
Cc: linux-ide@vger.kernel.org

On Thu, 08 Feb 2007 14:36:10 +0100, Matthias Schniedermeyer wrote:
> In two computer i have an onboard AHCI controller and hotplugging works like a charm. (The few times i actually tried that)
> 
> In another computer i have 2 Promise TX4 controllers and i couldn't find the information if 2.6.20 finally brought hotplug support for the TX4.

Hotplugging hasn't been implemented yet for sata_promise. I hope
to have a look at it soonish, but I can't say exactly when.

/Mikael
