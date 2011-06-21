From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5] ahci: move ahci_sb600_softreset to libahci.c and
 rename it
Date: Tue, 21 Jun 2011 11:53:57 +0200
Message-ID: <BANLkTin0V=jRz7mr1cWYgb3aoShfO30EtA@mail.gmail.com>
References: <BANLkTik-L1MNQspeaMhfxe4Uy1YGV+t6FA@mail.gmail.com>
	<1308647858-1821-1-git-send-email-yuanlmm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308647858-1821-1-git-send-email-yuanlmm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuan-Hsin Chen <yuanlmm@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sshtylyov@mvista.com, Yuan-Hsin Chen <yhchen@faraday-tech.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Tue, Jun 21, 2011 at 11:17 AM, Yuan-Hsin Chen <yuanlmm@gmail.com> wrote:
> From: Yuan-Hsin Chen <yhchen@faraday-tech.com>
>
> ahci_sb600_softreset was in ahci.c. This function is used
> to fix soft reset failure and renames as ahci_pmp_retry_softreset
> in libahci.c.
>
> Signed-off-by: Yuan-Hsin Chen <yhchen@faraday-tech.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks for your persistence. :)

-- 
tejun
