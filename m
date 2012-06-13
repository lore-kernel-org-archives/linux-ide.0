From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH V3 1/3] ata: pata_arasan: Add clk_{un}prepare() support
Date: Wed, 13 Jun 2012 10:12:39 +0100
Message-ID: <CAOh2x==5dGi4fyk3dYwSaBVYD-jD9tLOjbLffLi=LLT808O-oA@mail.gmail.com>
References: <cover.1336536285.git.viresh.kumar@st.com>
	<9848a1a6838c4f3a7e0cbd6cdc3bc6146fd2e2cc.1336536285.git.viresh.kumar@st.com>
	<4FBBF09D.1010607@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54994 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab2FMJMk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jun 2012 05:12:40 -0400
Received: by yenm10 with SMTP id m10so307344yen.19
        for <linux-ide@vger.kernel.org>; Wed, 13 Jun 2012 02:12:39 -0700 (PDT)
In-Reply-To: <4FBBF09D.1010607@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com, spear-devel@list.st.com

Hi Jeff,

On Tue, May 22, 2012 at 9:01 PM, Jeff Garzik <jeff@garzik.org> wrote:
> On 05/09/2012 12:08 AM, Viresh Kumar wrote:
>>
>> clk_{un}prepare is mandatory for platforms using common clock framew=
ork.
>> Since
>> this driver is used by SPEAr platform, which supports common clock
>> framework,
>> add clk_{un}prepare() support for it.
>>
>> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
>> ---
>> =A0drivers/ata/pata_arasan_cf.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
>
>
>
> these do not apply to upstream, for me...
>

Sorry for being late. I rebased them on linux-next that time as they
had few dependency commits there.
Can you try it there?

--
Viresh
