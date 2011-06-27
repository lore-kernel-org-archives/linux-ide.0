From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ata: sata_dwc_460ex: fix error path
Date: Mon, 27 Jun 2011 13:21:52 +0400
Message-ID: <4E084BB0.10806@mvista.com>
References: <1284317830-5022-1-git-send-email-segooon@gmail.com> <4D5C1326.2010101@ru.mvista.com> <4D628543.5090700@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D628543.5090700@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vasiliy Kulikov <segooon@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, kernel-janitors@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Rupjyoti Sarmah <rsarmah@appliedmicro.com>, Prodyut Hazarika <phazarika@appliedmicro.com>, Grant Likely <grant.likely@secretlab.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 21-02-2011 18:31, Sergei Shtylyov wrote:

>>> Free all allocated resources on error path.

>>> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
>>> ---
>>> I cannot compile this driver at all, so it is not tested.

>> I can at least compile-test the patch...

> No new errors/warnings are added by the patch.

    Vasiliy, could you repost this patch? I'm not sure why Jeff hasn't taken 
it, maybe he will now...

WBR, Sergei
