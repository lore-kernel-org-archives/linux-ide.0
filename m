From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] SATA: Fine-tuning for two function implementations
Date: Fri, 28 Apr 2017 17:53:34 -0400
Message-ID: <20170428215334.GH22354@htj.duckdns.org>
References: <df754c7a-2100-7169-0d40-b981ccd952a1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <df754c7a-2100-7169-0d40-b981ccd952a1@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Tue, Apr 18, 2017 at 10:00:37PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 18 Apr 2017 21:54:32 +0200
> 
> A few update suggestions were taken into account
> from static source code analysis.

Hmmm, allocs -> callocs.  Are these actually beneficial?  If so, why?
Because one multiplication is rolled into the call?

Thanks.

-- 
tejun
