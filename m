From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: RFC: declaring DT match tables (2nd take)
Date: Sat,  1 Jun 2019 15:52:55 +0200
Message-ID: <1559397179-5833-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: vireshk@kernel.org, b.zolnierkie@samsung.com, axboe@kernel.dk, herbert@gondor.apana.org.au, davem@davemloft.net, linux-ide@vger.kernel.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi folks,


few days ago I've posted a RFC for getting rid of many #ifdef CONFIG_OF
cases by using a macro that checks for it on its own.
(see: "RFC: get rid of #ifdef CONFIG_OF's around of match tables")

I've already mentioned I'm working on another approach that not just
cares about adding the table to the module, but the also the declaration
of the table itself. Here it is:

Introducing a macro MODULE_DECLARE_OF_TABLE(foo, entries), which declares
a static struct of_device_id array, fills in the entries (automatically
adds the sentinel) and calls MODULE_DEVICE_TABLE() - if CONFIG_OF is
enabled.

The current version isn't fully noop in absence of CONFIG_OF, but also
declares a static const *pointer* variable, initialized NULL, with the
same name. The idea behind: we don't need to use of_match_ptr() anymore.

I believe, the compiler should be clever enough to find out that this
field is always NULL and can't ever change, so it can be easily optimized
away. (correct me if I'm wrong).


Please have a look at the following example patches and let me know,
whether we can go that way. If you're okay w/ that, I'll continue
w/ converting the whole tree to using this approach. I've already did
most of it, yet needs to be sorted out into easily digestable patches :)
And I'd also do the same w/ the other table types (ACPI, PCI, I2C, ...)

By the way: an interesting question arises: shall that conversion be
done *everywhere*, or just those sites where explicit CONFIG_OF's are
involved ?


have fun,

--mtx
