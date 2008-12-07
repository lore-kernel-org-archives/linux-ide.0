From: Yan Seiner <yan@seiner.com>
Subject: Re: MCP55 disk activity LEDs don't flash
Date: Sat, 06 Dec 2008 17:00:10 -0800
Message-ID: <493B201A.1070404@seiner.com>
References: <493A8767.5030200@seiner.com> <493AE05B.2010707@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from flatoutfitness.com ([66.178.130.209]:54205 "EHLO www.seiner.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004AbYLGBAN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Dec 2008 20:00:13 -0500
Received: from www.seiner.com ([192.168.128.6] ident=yan)
	by www.seiner.com with esmtp (Exim 4.69)
	(envelope-from <yan@seiner.com>)
	id 1L980I-00006g-Rv
	for linux-ide@vger.kernel.org; Sat, 06 Dec 2008 17:00:10 -0800
In-Reply-To: <493AE05B.2010707@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Robert Hancock wrote:
>
> The backplane may be expecting the host to control the LEDs. You'd 
> have to check with the manufacturer to be sure. As for how it would do 
> this, there's such a thing as enclosure management support in SATA, 
> but the sata_nv driver doesn't support it. If there is a way to use it 
> on that controller, only NVidia would know, since they've provided no 
> documentation for their pre-AHCI controllers. Some AHCI controllers do 
> have support for this.. 

This is a Norco DS-600s, a really nice rackmount case which has been 
discontinued by Norco...  Unfortunately Norco doesn't have any sort of 
enduser support and that case was mostly sold as a security DVR 
enclosure to OEMs so I have not been able to find anything on it.

Unless there's some easy way to figure out what the backplane is doing 
I'll just put up with it.  It's rock solid but it's kind of annoying to 
have all those drives and no blinkie-lights.  :-)

--Yan
