From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
Date: Tue, 17 Jun 2014 10:23:01 -0600
Message-ID: <53A06B65.7030407@wwwdotorg.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-9-git-send-email-mperttunen@nvidia.com>
 <1470404.13mIFv0Hnj@amdc1032> <53A0686F.4000303@wwwdotorg.org>
 <20140617161320.GG31819@htj.dyndns.org>
 <20140617161447.GH31819@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140617161447.GH31819@htj.dyndns.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, pdeschrijver@nvidia.com, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, linux-ide@vger.kernel.org, thierry.reding@gmail.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 06/17/2014 10:14 AM, Tejun Heo wrote:
> On Tue, Jun 17, 2014 at 12:13:20PM -0400, Tejun Heo wrote:
>> On Tue, Jun 17, 2014 at 10:10:23AM -0600, Stephen Warren wrote:
>>>> sata_writel() and sata_read() static inlines don't seem to add any value.
>>>>
>>>> Can they be removed?
>>>
>>> Such functions are quite idiomatic in drivers, and serve to simplify all
>>> the call-sites by removing the need to write out the addition of the
>>> base address everywhere.
>>
>> I think it obfuscates more than helps.  If you absoluately have to
>> keep it, please at least name it so that it's clear that it's
>> something specific to this driver.
> 
> Please also drop inline.  It isn't a difficult optimization to perform
> for the compiler.

There are probably hundreds of drivers marking those functions inline.
If they aren't marked inline, it'll just stick out as unusual when
people read them all, and then they'll send patches to fix it.
