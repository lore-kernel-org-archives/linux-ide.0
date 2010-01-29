From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Thu, 28 Jan 2010 22:56:05 -0500
Message-ID: <4B625C55.1050807@teksavvy.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>	 <20100126160243.018b87e3@lxorguk.ukuu.org.uk>	 <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>	 <4B5F62C2.4000800@pobox.com> <aacba7e1001261624m4358e4ebwcf8e2305b0c5fc16@mail.gmail.com> <4B60C30D.4040203@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:8871 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755052Ab0A2D4J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2010 22:56:09 -0500
In-Reply-To: <4B60C30D.4040203@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vishal Rao <vishalrao@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org

Mark Lord wrote:
>
> Okay, that's ICH9.  I'll see if I have an ICH9 kicking around here
> that I can put an OCZ/Indilinx drive onto.  The current v1.5 OCZ firmware
> is probably pretty close to the 1916 build version that your Crucial has.
..

The best I have is ICH7 and ICH8.
My OCZ/Indilinx drives all work without any issues in NCQ on those systems,
using the latest OCZ firmware -- similar vintage to your broken Crucial drive.

Cheers

