From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH -next] ata: PATA_ARASAN_CF depends on DMADEVICES
Date: Tue, 24 May 2011 09:08:50 +0530
Message-ID: <4DDB284A.6040603@st.com>
References: <20110520165507.cba539d5.sfr@canb.auug.org.au> <20110522173227.5ba18817.randy.dunlap@oracle.com> <4DD9D5EB.3060807@st.com> <4DDA89A2.8010604@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4DDA89A2.8010604@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 05/23/2011 09:51 PM, Randy Dunlap wrote:
>>> >>  config PATA_ARASAN_CF
>>> >>  	tristate "ARASAN CompactFlash PATA Controller Support"
>>> >> +	depends on DMADEVICES
>>> >>  	select DMA_ENGINE
>> > 
>> > Randy,
>> > 
>> > I think we can also remove this "select DMA_ENGINE" line.
> In that case, the newly added "depends on" line is not needed either,
> since the "select DMA_ENGINE" is what causes the kconfig warning message.
> 

Some sort of dependency must be present as PATA_ARASAN is using DMAENGINE
routines and it will not compile unless DMA_ENGINE is enabled.

So, depends on DMADEVICES will solve all these issues.

-- 
viresh
