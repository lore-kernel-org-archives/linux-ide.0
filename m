From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH9 2 port SATA controller port map?
Date: Thu, 27 Sep 2007 10:08:03 +0900
Message-ID: <46FB0273.60302@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE0701CC0C09@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:13811 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbXI0ETn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 00:19:43 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2202053rvb
        for <linux-ide@vger.kernel.org>; Wed, 26 Sep 2007 21:19:42 -0700 (PDT)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0701CC0C09@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org

Gaston, Jason D wrote:
> Hello,
> 
> ICH9 has DeviceID's for 2 port, IDE mode, SATA controllers.  The current
> port map in ata_piix is setup for the 4 port controllers.  This seems to
> work ok, but I wonder if a new port map should be defined for the 2 port
> controllers, where the two ports are PM, SM?  You can refer to the ICH9
> Datasheet on intel.com for detail.

Yes, please go ahead and define new entry for the controllers.  Thanks.

-- 
tejun

