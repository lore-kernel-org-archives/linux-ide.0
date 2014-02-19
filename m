From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
Date: Wed, 19 Feb 2014 09:04:58 -0500
Message-ID: <20140219140458.GA10134@htj.dyndns.org>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
 <20140218233645.GP31892@mtj.dyndns.org>
 <20140219083025.GB10504@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:33999 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbaBSOFC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Feb 2014 09:05:02 -0500
Content-Disposition: inline
In-Reply-To: <20140219083025.GB10504@lee--X1>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alexandre.torgue@st.com, linux-ide@vger.kernel.org, hdegoede@redhat.com

Hello, Lee.

On Wed, Feb 19, 2014 at 08:30:25AM +0000, Lee Jones wrote:
> Can I do this as a subsequent patch though? The current patch fits
> neatly onto our internal stable kernel (currently v3.10). The added
> work will require back-porting Hans' patch-set, which has not yet
> reached Mainline.

Hmm.... I'll apply Hans' patchset pretty soon and we still have some
time in this devel cycle so I'd much prefer applying the final patch.

Thanks.

-- 
tejun
