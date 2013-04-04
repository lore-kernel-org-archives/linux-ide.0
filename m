From: Eric Valette <eric.valette@free.fr>
Subject: Re: Strange trace in dmesg on kernel 3.8.5
Date: Thu, 04 Apr 2013 21:03:09 +0200
Message-ID: <515DCE6D.7080203@free.fr>
References: <515DD32F.3030509@free.fr> <20130404194404.GA8082@pd.tnic> <1365108338.3072.3.camel@shinybook.infradead.org>
Reply-To: eric.valette@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365108338.3072.3.camel@shinybook.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 04/04/2013 22:45, David Woodhouse wrote:
> On Thu, 2013-04-04 at 21:44 +0200, Borislav Petkov wrote:
>>> ahci 0000:00:1f.2: DMA-API: device driver maps memory fromstack
>>> [addr=ffff88040df2da50]
> I fixed this already. 
>
> https://git.kernel.org/cgit/linux/kernel/git/jgarzik/libata-dev.git/commit/?h=upstream-fixes&id=8e725c7f8a60feaa88edacd4dee2c754d5ae7706
>
Thanks for the support. I will apply the patch manually and wait for 3.8.6

-- eric
 
