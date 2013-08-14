From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 1/3] devicetree: create a separate binding description
 for sata_highbank
Date: Wed, 14 Aug 2013 16:27:28 -0400
Message-ID: <20130814202728.GJ28628@htj.dyndns.org>
References: <1374851518-4802-1-git-send-email-mark.langsdorf@calxeda.com>
 <1376504612-17340-1-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:59013 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933026Ab3HNU1d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Aug 2013 16:27:33 -0400
Content-Disposition: inline
In-Reply-To: <1376504612-17340-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob.herring@calxeda.com, sergei.shtylyov@cogentembedded.com

Hello,

On Wed, Aug 14, 2013 at 01:23:30PM -0500, Mark Langsdorf wrote:
>  Documentation/devicetree/bindings/ata/sata_highbank.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Any ideas on how these should be routed?  The above doesn't apply to
libata or master as the file doesn't exist there yet.

Thanks.

-- 
tejun
