From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: fallback to the other IDENTIFY on device error
Date: Tue, 08 May 2007 10:02:03 +0200
Message-ID: <46402E7B.8090702@gmail.com>
References: <20070427175205.GD7809@electro-mechanical.com> <4635C35D.1020807@gmail.com> <20070430202107.GF5942@electro-mechanical.com> <4636C2C7.8090206@gmail.com> <20070501121703.GH5942@electro-mechanical.com> <46373AEE.6070908@rtr.ca> <20070501131818.GA18521@electro-mechanical.com> <46374354.7040307@gmail.com> <20070501172117.GA20328@electro-mechanical.com> <463F56F2.3010106@gmail.com> <20070507180547.GB4215@electro-mechanical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934560AbXEHICZ@vger.kernel.org>
In-Reply-To: <20070507180547.GB4215@electro-mechanical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Thompson <wt@electro-mechanical.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com
List-Id: linux-ide@vger.kernel.org

William Thompson wrote:
> On Mon, May 07, 2007 at 06:42:26PM +0200, Tejun Heo wrote:
>> It seems the world isn't as frank as we thought and some devices lie
>> about who they are.  Fallback to the other IDENTIFY if IDENTIFY fails
>> with device error.  As this is the strategy used by IDE for a long
>> time, it shouldn't cause too much problem.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> Cc: William Thompson <wt@electro-mechanical.com>
>> ---
>> Willam, please verify this fixes your problem.  Jeff, after all, we
>> seem to need this.  :-(
> 
> Even though you have a different libata-core.c than I, the patch does work!

The different part is in libata devel tree and the rejection at the
variable declaration doesn't matter as long as you add the variable.
Thanks for testing.  :-)

-- 
tejun
