From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: ICH9 2 port SATA controller port map?
Date: Mon, 1 Oct 2007 10:33:59 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0701CF304E@orsmsx420.amr.corp.intel.com>
References: <39B20DF628532344BC7A2692CB6AEE0701CC0C09@orsmsx420.amr.corp.intel.com> <46FB0273.60302@gmail.com> <39B20DF628532344BC7A2692CB6AEE0701CF2D29@orsmsx420.amr.corp.intel.com> <46FDDFA5.8040209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52765 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbXJAReB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 13:34:01 -0400
Content-class: urn:content-classes:message
In-Reply-To: <46FDDFA5.8040209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

>> What is the difference between NA and RV?  If the controller only has
>> access to 2 ports, does it matter which I set the nonexistent port
>> values to in the map?
>
>NA is used for unimplemented ports of a valid configuration while RV is
>used to mark invalid MAP value.  So, NA should be mixed with P[0-3]
>while RV can't be mixed with any other values.
>
>--
>Tejun

When you say "can't be mixed" do you mean I should not have [P0 RV P1
RV] on the same line?  If that is the case, then I assume my only
choice, for the 2 port controller (physically ports 5 & 6) would be [P0
NA P1 NA].

Thanks!

Jason
