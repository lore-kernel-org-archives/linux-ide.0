From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Allow ATA_ passthrough command through sg.
Date: Mon, 29 Jun 2009 23:20:45 +0100
Message-ID: <20090629232045.14a426b6@lxorguk.ukuu.org.uk>
References: <1246310665-31727-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1246310665-31727-1-git-send-email-gwendal@google.com>
Sender: linux-scsi-owner@vger.kernel.org
Cc: jens.axboe@oracle.com, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
List-Id: linux-ide@vger.kernel.org

On Mon, 29 Jun 2009 14:24:25 -0700
Gwendal Grignou <gwendal@google.com> wrote:

> We can already send ATA specific commands using /dev/sd device files.
> This patch allow to use /dev/sg device files as well.

That seems a very very bad idea. The point of the filters is only to
allow through commands that are safe for all users with read or write
permission to use.

Backdooring it with arbitary passthrough ATA12/ATA16 commands doesn't
seem very wise.

