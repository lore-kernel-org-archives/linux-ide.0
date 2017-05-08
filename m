From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: use setup_timer
Date: Mon, 08 May 2017 17:37:26 -0400 (EDT)
Message-ID: <20170508.173726.2149063487593483733.davem@davemloft.net>
References: <0ff6e139159043e3416b0e5bc89e9aa5399bbb8e.1490601847.git.geliangtang@gmail.com>
        <964230281324b7c18ec70296a8a3cd1caae13cb6.1490602149.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <964230281324b7c18ec70296a8a3cd1caae13cb6.1490602149.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: geliangtang@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Geliang Tang <geliangtang@gmail.com>
Date: Sun,  9 Apr 2017 09:41:32 +0800

> Use setup_timer() instead of init_timer() to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Applied.
