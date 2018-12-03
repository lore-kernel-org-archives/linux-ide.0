From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Malformatted switch statment
Date: Sun, 02 Dec 2018 22:04:12 -0800 (PST)
Message-ID: <20181202.220412.1682693749796493451.davem@davemloft.net>
References: <20181028164546.17178-1-joris.gutjahr@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181028164546.17178-1-joris.gutjahr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joris.gutjahr@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Joris Gutjahr <joris.gutjahr@gmail.com>
Date: Sun, 28 Oct 2018 17:45:46 +0100

> I fixed this coding style error I got after running
> checkpatch --file on this file.
> The problem was that the whole case block was on one line.
> 
> Signed-off-by: Joris Gutjahr <joris.gutjahr@gmail.com>

Frankly I think the existing code is more compact and easier
to read and understand.

Checkpatch is a tool, and it's results need be interpreated
and evaluated by human beings.  It's not to be taken as the
final verdict.

I'm not applying this, sorry.
