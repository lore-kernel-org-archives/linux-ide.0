From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] ATA: Debugging options for the ATA subsystem
Date: Thu, 9 Jun 2011 09:22:36 +0530
Message-ID: <4DF04384.1040908@st.com>
References: <1edabe459c04313f2e9bb4282a7bea208272e618.1307513666.git.viresh.kumar@st.com> <4DEF89B2.6010601@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:42499 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752684Ab1FIDw5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2011 23:52:57 -0400
In-Reply-To: <4DEF89B2.6010601@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 06/08/2011 08:09 PM, Sergei Shtylyov wrote:
>> > +config ATA_DEBUG
>> > +        bool "ATA debugging"
>> > +        help
>> > +          This is an option for use by developers; most people should
>> > +          say N here.  This enables ATA core and driver debugging.
>> > +
>> > +config ATA_VDEBUG
>> > +        bool "ATA verbose debugging"
>> > +        depends on ATA_DEBUG != n
>     Why not just on ATA_DEBUG? It can only be 'y' or 'n'.

Yes, that's correct! Will resend it.

-- 
viresh
