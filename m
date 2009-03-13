From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is active for GenIIe
Date: Fri, 13 Mar 2009 09:07:13 +0100
Message-ID: <200903130907.15965.elendil@planet.nl>
References: <200903110813.25650.elendil@planet.nl> <49B918F7.2060401@rtr.ca> <49B91B86.7070309@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Cpsmtpm-eml107.kpnxchange.com ([195.121.3.11]:60985 "EHLO
	CPSMTPM-EML107.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751260AbZCMIHT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Mar 2009 04:07:19 -0400
In-Reply-To: <49B91B86.7070309@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Thursday 12 March 2009, Mark Lord wrote:
> And after you answer that, then does this revised patch work?
> If not, then perhaps you could try and figure out why,
> since I just don't have your hardware available to me here.

I've just tested (on top of .29-rc8) the new development version of the 
driver you sent me privately, which essentially contains this patch, and 
it worked perfectly!

In the final patch, please add my:
Reported-by: Frans Pop <elendil@planet.nl>
Tested-by: Frans Pop <elendil@planet.nl>

Thanks Mark.
