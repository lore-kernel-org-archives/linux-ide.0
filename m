From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] drivers: ide: Include appropriate header file in
 ide-cd_verbose.c
Date: Tue, 17 Dec 2013 22:42:54 +0300
Message-ID: <52B0A93E.7090503@cogentembedded.com>
References: <d24d7befadfbfb9501d0e873f13e39fd42ec893b.1387278225.git.rashika.kheria@gmail.com> <20131217111920.GA30592@pd.tnic> <20131217164403.GD1062@leaf> <20131217175451.GI30592@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131217175451.GI30592@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Josh Triplett <josh@joshtriplett.org>
Cc: Rashika Kheria <rashika.kheria@gmail.com>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 12/17/2013 08:54 PM, Borislav Petkov wrote:

>> The two proposed patches here are extremely low risk, don't actually
>> change the compiled code in any way like some of those did, and fix
>> real compiler warnings.

> Considering the fact that IDE is about to be deleted (unless something
> embedded still wants it which I hardly doubt

    You're right in your doubting: there are quite a lot of drivers used by 
embedded platforms that nobody has bothered to convert to libata thus far.

MBR, Sergei
