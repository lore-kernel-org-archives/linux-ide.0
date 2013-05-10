From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] IDE: bugfix of IDE PIO size calculation
Date: Fri, 10 May 2013 22:56:19 +0400
Message-ID: <518D42D3.3010709@cogentembedded.com>
References: <20130510184711.32151.70337.stgit@linux-yegoshin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130510184711.32151.70337.stgit@linux-yegoshin>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net
List-Id: linux-ide@vger.kernel.org

Hello.

On 05/10/2013 10:47 PM, Leonid Yegoshin wrote:

> IDE PIO calculates size wrong.
> Proven by test on MIPS Malta platform with multiple CPU types
> with bootparam flag "ide-core.nodma=0.0".
>
> It is still needed to test non-DMA IO.
>
> Change-Id: Id82c2bc5965d85960846db53d84846d9a05d75a3

    Please get rid of this line.

> Author: Leonid Yegoshin <yegoshin@mips.com>

     From: line at the start of message is used for that.

> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> (imported from commit 43cee988ce0aa8d2ca1eec014d25f014e95eefe6)
> (imported from commit d74805b8b12cada05df811e112eb7e3ec197d565)

     What are those two lines? Why are they here, in upstream patch?

WBR, Sergei
