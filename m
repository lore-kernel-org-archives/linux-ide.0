From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 9/20] libata: reimplement LLD init_one()'s using new init
 helpers
Date: Tue, 19 Sep 2006 15:11:19 +0900
Message-ID: <450F8A07.4090604@gmail.com>
References: <11559779721014-git-send-email-htejun@gmail.com> <450F8326.7090108@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:63192 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964950AbWISGL1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Sep 2006 02:11:27 -0400
Received: by py-out-1112.google.com with SMTP id n25so5666126pyg
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 23:11:26 -0700 (PDT)
In-Reply-To: <450F8326.7090108@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Helloooo,

Jeff Garzik wrote:
> Unfortunately, while this patch seems correct, it is also difficult to 
> review, and I'm thinking it reflects that another approach may need to 
> be considered.
> 
> Usually the drivers and API are often change in small chunks, whereas 
> this patchset is more along the lines of
> 1) add new helpers
> 2) update everything to use new helpers
> 3) delete old helpers
> 
> The previous approach was closer to
> * small update to API & drivers
> * small update to API & drivers
> * small update to API & drivers
> ...
> 
> I recognize that we are changing the LLDD init model, but I bet if you 
> think really hard, you could come up with a less-drastic transition path.

This patchset has been one of the most painful to carry around due to 
dependencies on everything and the wide range of changes.  I agree that 
there can be a better way to split this patch if I think *really* hard, 
but was kind of hoping I could avoid that.  :-)

I'll try to reshuffle the whole set as you suggested but I can't say for 
sure.  Please note that lots of previous EH changes were done this way - 
implement new framework while leaving old one alone, convert LLDs, kill 
old framework.  I have to admit that this patchset is more drastic tho.

Thanks.

-- 
tejun
