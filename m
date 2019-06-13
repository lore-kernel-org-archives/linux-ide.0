From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] libata: Extend quirks for the ST1000LM024 drives with
 NOLPM quirk
Date: Thu, 13 Jun 2019 03:18:15 -0600
Message-ID: <96b954ce-0c1d-7639-8b73-5dfc04b772b3@kernel.dk>
References: <20190611143259.28647-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190611143259.28647-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 6/11/19 8:32 AM, Hans de Goede wrote:
> We've received a bugreport that using LPM with ST1000LM024 drives leads
> to system lockups. So it seems that these models are buggy in more then
> 1 way. Add NOLPM quirk to the existing quirks entry for BROKEN_FPDMA_AA.

Applied, thanks.

-- 
Jens Axboe
