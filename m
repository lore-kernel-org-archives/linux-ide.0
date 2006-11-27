From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH] IDE: typo in ide-io.c leads to faulty assignment
Date: Mon, 27 Nov 2006 17:31:10 +0100
Message-ID: <87ac2c4zsh.fsf@denkblock.local>
References: <87k61h3pu2.fsf@denkblock.local>
	<9a8748490611270801g38417047ybcf4304bad9ad673@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.225.107.202]:58855 "EHLO nebensachen.de")
	by vger.kernel.org with ESMTP id S1758356AbWK0QbT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Nov 2006 11:31:19 -0500
In-Reply-To: <9a8748490611270801g38417047ybcf4304bad9ad673@mail.gmail.com>
	(Jesper Juhl's message of "Mon\, 27 Nov 2006 17\:01\:16 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> These two lines :
>
> -		args->handler = task_no_data_intr;
> +		args->handler = &task_no_data_intr;
>
> do the same thing.

Thanks for explaining, obviously I got a bit confused.

Sorry for the noise.

Elias
