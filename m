From: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
Subject: Re: ata link not reset properly
Date: Thu, 24 Jun 2010 09:13:44 +0200
Message-ID: <4C2305A8.4070708@odi.ch>
References: <4C223F8A.9030306@odi.ch> <4C224429.6010705@kernel.org> <4C224502.2040206@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C224502.2040206@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 23.06.2010 19:31, Tejun Heo wrote:
> Meh, it won't work.  It's failing softreset so we should be checking
> reset try counts.  I'll try to write up something tomorrow.

I am happy to try patches. The problem shows up maybe once a month only,
however. Interestingly it only occurs on ata2 with a IBM hdd, never on the first
channel with a maxtor. I can also try and attach the dvd on the first channel
and see if that makes any difference.

ata1.00: ATA-5: MAXTOR 6L020J1, A93.0500, max UDMA/133
ata2.00: ATA-5: IC25N030ATCS04-0, CA3OA71A, max UDMA/100
ata2.01: ATAPI: Pioneer DVD-ROM ATAPIModel DVD-115  0127, E1.27, max UDMA/33

Thanks.
 Ortwin
