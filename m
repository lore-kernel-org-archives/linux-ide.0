From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata hotplug question
Date: Tue, 01 Dec 2009 16:39:01 +1100
Message-ID: <1259645941.2076.225.camel@pasglop>
References: <1259561052.2076.73.camel@pasglop>
	 <1259624651.2076.158.camel@pasglop>  <4B1459B5.40504@kernel.org>
	 <1259635420.2076.180.camel@pasglop> <1259644647.2076.204.camel@pasglop>
	 <4B14A809.8000304@kernel.org> <1259645409.2076.213.camel@pasglop>
	 <4B14AAD0.4060806@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55291 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbZLAFjf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 00:39:35 -0500
In-Reply-To: <4B14AAD0.4060806@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Tue, 2009-12-01 at 14:34 +0900, Tejun Heo wrote:
> In effect, they would be the same but if the hotplug notification can
> be made reliable, I think using DFLAG_DETACH would be better as
> there's already other users doing that (user requested detach and ACPI
> dock removal). 

Allright. I just need to find how to tell it at boot that it's detached
to avoid time probing a non existing interface but that's no big deal.

Cheers,
Ben.


