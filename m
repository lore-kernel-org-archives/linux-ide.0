From: "Jian Peng" <jipeng@broadcom.com>
Subject: RE: questions regarding possible violation of AHCI spec in AHCI
 driver
Date: Wed, 8 Dec 2010 17:30:17 -0800
Message-ID: <E18F441196CA634DB8E1F1C56A50A874319FA38E23@IRVEXCHCCR01.corp.ad.broadcom.com>
References: <E18F441196CA634DB8E1F1C56A50A874319F70C1F2@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4CFEE569.4030204@gmail.com> <4CFF58D2.4040006@kernel.org>
 <E18F441196CA634DB8E1F1C56A50A874319FA38C43@IRVEXCHCCR01.corp.ad.broadcom.com>,<4CFFCD56.6050608@kernel.org>
 <E18F441196CA634DB8E1F1C56A50A874319FA7E36E@IRVEXCHCCR01.corp.ad.broadcom.com>,<4CFFD3EB.10800@kernel.org>
 <E18F441196CA634DB8E1F1C56A50A874319FA7E36F@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4CFFE29C.7080205@kernel.org>
 <E18F441196CA634DB8E1F1C56A50A874319FA38CD3@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4D000C8B.5040904@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D000C8B.5040904@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi, Tejun,

I will go over with chip designer on all detail of this race condition again. AFAIK, our controller reacted to ST bit change but lack of full handshaking between SW and HW leads to failure finally. 

I can definitely help checking all available controllers I can get. Schedule wise, it is not too bad since this AHCI core is part of SOC instead of standalone controller so we have manageable kernel and patches release for our customers. To help AHCI driver to be more compliant with spec, and also fix specific problem in our controller, it requires some actions.

I will post my findings on other controllers after testing it.

Thanks,
Jian


-----Original Message-----
From: Tejun Heo [mailto:tj@kernel.org] 
Sent: Wednesday, December 08, 2010 2:54 PM
To: Jian Peng
Cc: Robert Hancock; linux-kernel@vger.kernel.org; jgarzik@pobox.com; ide
Subject: Re: questions regarding possible violation of AHCI spec in AHCI driver

Hello, Jian.

On 12/08/2010 09:09 PM, Jian Peng wrote:
> The controller may take much longer time to recover in this case,
> and leads to wrong HW state after stop_engine() inside
> ahci_hardreset() and cause device type checking failure due to
> unfinished HW state change and missing D2H FIS after start_engine()
> again inside ahci_hardreset(). I guess this is the reason why AHCI
> spec try to emphasize.

I don't necessarily agree there.  The requirement is impossible to
reliably satisfy to begin with (it's inherently racy) and most specs
are filled with "the outcome is undefined" when they don't _need_ to
be well defined.  The hardware can do "eh.. well, whatever, I don't
know" but shouldn't get lost and fail to react to further
state-resetting actions.

> Yes, without this change, Broadcom controller will fail due to above
> reason.

Okay, so, the controller goes bonkers if ST is set when prerequisites
are not met.  You know that the problem can still happen with the
proposed change, right?  It's much less likely but definitely can and
actually is likely to happen once in a blue moon.  It isn't too
uncommon for link to take some time to stabilize after a PHY event
(including hardreset) and some devices will end up sending multiple
D2H Reg FISes in the process with conflicting status.  Also, note that
the delay between the check and ST setting could be substantial
especially with parallel probing / booting.

I'm not objecting to the change but you guys probably want to fix the
controller in following revisions.  If we're gonna make the change,
I'd like to go with the previous version without the vendor check.
What is the timeframe for the controller release?  Would it be enough
to merge the change during 2.6.38-rc1?  After baking it for some time
in 2.6.38, we can propagate the change back through -stable.

Thanks.

-- 
tejun
