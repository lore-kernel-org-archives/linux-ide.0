From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH resubmit] /drivers/ata ioremap returncode check
Date: Mon, 03 Sep 2007 17:29:57 +0900
Message-ID: <46DBC605.9040401@gmail.com>
References: <648310.70195.qm@web44903.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <648310.70195.qm@web44903.mail.sp1.yahoo.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: postfail@hushmail.com
Cc: brandon@ifup.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Scott Thompson wrote:
> Patchset against 2.6.23-rc3.  corrects missing ioremap return 
> checks, resending after fixing for documentation making changes suggested...
> 
> As for suggestions, I did fix the {} that weren't needed.  I did not add in a
> "printk" err or warn statement as the rest of the module does not contain these
> messages.  When auditing (as I am for ioremap checking here) I am attempting
> to keep changes "in the style of their surroundings".  Otherwise it's massive
> scope screep on these patches.
>  
> Signed-off-by: Scott Thompson <postfail <at> hushmail.com>

Acked-by: Tejun Heo <htejun@gmail.com>

It would be better to start the subject line with pata_ixp4xx_cf: but
maybe Jeff can fix it up while applying.

Thanks.

-- 
tejun
