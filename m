From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: Where should i add Compact flash driver?
Date: Tue, 02 Nov 2010 22:39:14 +0300
Message-ID: <4CD068E2.9030301@ru.mvista.com>
References: <4CCFA0B6.7050602@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56114 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079Ab0KBTkf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Nov 2010 15:40:35 -0400
Received: by ewy7 with SMTP id 7so4298181ewy.19
        for <linux-ide@vger.kernel.org>; Tue, 02 Nov 2010 12:40:33 -0700 (PDT)
In-Reply-To: <4CCFA0B6.7050602@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
Cc: linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>

Hello.

viresh kumar wrote:

> I am developing driver for CF+ module for SPEAr Platform.
> I am not sure where should i add it? PCMCIA or somewhere else?

    Depends on in which mode you're going to use it. If it's True IDE mode, then 
drivers/ata/, otherwise drivers/pcmcia/...

WBR, Sergei

